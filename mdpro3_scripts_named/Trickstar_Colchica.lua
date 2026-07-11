--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Trickstar Colchica  (ID: 298846)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Fairy
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 200
-- Setcode: 0xfb
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 non-Link "Trickstar" monster
-- You can only Special Summon "Trickstar Colchica(s)" once per turn.
-- When a monster is destroyed by battle involving your "Trickstar" monster, while this card is in your
-- GY: You can banish this card, then target that destroyed monster; inflict damage to your opponent
-- equal to that monster's ATK.
-- You can only use this effect of "Trickstar Colchica" once per turn.
--[[ __CARD_HEADER_END__ ]]

--トリックスター・コルチカ
local s,id,o=GetID()
function s.initial_effect(c)
	c:SetSPSummonOnce(id)
	aux.AddLinkProcedure(c,s.mat,1,1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.damcon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(s.damtg)
	e1:SetOperation(s.damop)
	c:RegisterEffect(e1)
end
function s.mat(c)
	return c:IsLinkSetCard(0xfb) and not c:IsLinkType(TYPE_LINK)
end
function s.damfilter(c,tp,e)
	if c:IsSetCard(0xfb) and c:IsPreviousControler(tp) then return true end
	local rc=c:GetBattleTarget()
	return rc:IsSetCard(0xfb)
		and (not rc:IsLocation(LOCATION_MZONE) and rc:IsPreviousControler(tp)
			or rc:IsLocation(LOCATION_MZONE) and rc:IsControler(tp))
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(s.damfilter,1,nil,tp,e)
end
function s.tgfilter(c,e)
	return not c:IsType(TYPE_TOKEN) and c:IsFaceupEx() and c:GetBaseAttack()>0 and c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=eg:Filter(s.tgfilter,nil,e)
	if chk==0 then return g:GetCount()>0 end
	local bc=g:GetFirst()
	if g:GetCount()>1 then
		bc=g:FilterSelect(tp,s.tgfilter,1,1,nil,e):GetFirst()
	end
	Duel.SetTargetCard(bc)
	local dam=bc:GetBaseAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
end
