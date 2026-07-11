--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Burgundy the Magic Elf  (ID: 89974735)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1600 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a card(s) is discarded from your opponent's hand by card effect (except during the Damage Step):
-- You can inflict 400 damage to your opponent for each card discarded.
-- When this card is destroyed by battle and sent to the GY: You can discard 1 random card from your
-- opponent's hand.
-- You can only use each effect of "Burgundy the Magic Elf" once per turn.
--[[ __CARD_HEADER_END__ ]]

--魔法妖精 バーガンディ
local s,id,o=GetID()
function s.initial_effect(c)
	--dmg
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DISCARD)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.dmgcon)
	e1:SetTarget(s.dmgtg)
	e1:SetOperation(s.dmgop)
	c:RegisterEffect(e1)
	--handes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_HANDES_OPPO)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.handescon)
	e2:SetTarget(s.handestg)
	e2:SetOperation(s.handesop)
	c:RegisterEffect(e2)
end
function s.dmgfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_HAND) and c:IsPreviousControler(tp)
		and c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DISCARD)
end
function s.dmgcon(e,tp,eg,ep,ev,re,r,rp)
	return re and eg:IsExists(s.dmgfilter,1,nil,1-tp)
end
function s.dmgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=eg:FilterCount(s.dmgfilter,nil,1-tp)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*400)
end
function s.dmgop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(s.dmgfilter,nil,1-tp)
	Duel.Damage(1-tp,ct*400,REASON_EFFECT)
end
function s.handescon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function s.handestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
end
function s.handesop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(tp,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
