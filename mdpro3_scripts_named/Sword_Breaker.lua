--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Sword Breaker  (ID: 64689404)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Warrior
-- Rank: 6
-- ATK 2700 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 6 monsters
-- Once per turn: You can detach 1 Xyz Material from this card to declare 1 Monster Type; this card
-- gains the following effect.
-- At the start of the Damage Step, if this card battles a monster of a Type that has been declared:
-- Destroy that monster.
--[[ __CARD_HEADER_END__ ]]

--ソードブレイカー
function c64689404.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64689404,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c64689404.raccost)
	e1:SetTarget(c64689404.ractg)
	e1:SetOperation(c64689404.racop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64689404,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCondition(c64689404.descon)
	e2:SetTarget(c64689404.destg)
	e2:SetOperation(c64689404.desop)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c64689404.raccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c64689404.ractg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():GetLabel()~=RACE_ALL end
	if e:GetHandler():GetFlagEffect(64689404)==0 then
		e:GetHandler():RegisterFlagEffect(64689404,RESET_EVENT+RESETS_STANDARD,0,0)
		e:GetLabelObject():SetLabel(0)
	end
	local prc=e:GetLabelObject():GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL-prc)
	e:SetLabel(rc)
end
function c64689404.racop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() then
		local prc=e:GetLabelObject():GetLabel()
		local rc=bit.bor(e:GetLabel(),prc)
		e:GetLabelObject():SetLabel(rc)
		e:GetHandler():SetHint(CHINT_RACE,rc)
	end
end
function c64689404.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:GetFlagEffect(64689404)~=0 and bc and bc:IsFaceup() and bc:IsRace(e:GetLabel())
end
function c64689404.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c64689404.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
