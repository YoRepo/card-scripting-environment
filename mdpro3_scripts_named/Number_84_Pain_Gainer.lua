--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Number 84: Pain Gainer  (ID: 26556950)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Insect
-- Rank: 11
-- ATK 0 | DEF 0
-- Setcode: 0x48
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 11 monsters
-- You can also Xyz Summon this card by using a Rank 8, 9, or 10 DARK Xyz Monster you control with 2 or
-- more materials.
-- (Transfer its materials to this card.)
-- Gains DEF equal to the combined Ranks of all Xyz Monsters you control x 200.
-- While this card has material, each time your opponent activates a Spell/Trap Card, inflict 600
-- damage to your opponent immediately after it resolves.
-- Once per turn: You can detach 1 material from this card; destroy all face-up monsters your opponent
-- controls with DEF less than or equal to this card's.
--[[ __CARD_HEADER_END__ ]]

--No.84 ペイン・ゲイナー
function c26556950.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,11,2,c26556950.ovfilter,aux.Stringid(26556950,0),2)
	c:EnableReviveLimit()
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(c26556950.defval)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c26556950.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c26556950.damcon)
	e3:SetOperation(c26556950.damop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(26556950,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c26556950.descost)
	e4:SetTarget(c26556950.destg)
	e4:SetOperation(c26556950.desop)
	c:RegisterEffect(e4)
end
aux.xyz_number[26556950]=84
function c26556950.ovfilter(c)
	local rk=c:GetRank()
	return c:IsFaceup() and c:GetOverlayCount()>=2 and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK) and rk>=8 and rk<=10
end
function c26556950.defval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetRank)*200
end
function c26556950.regop(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	e:GetHandler():RegisterFlagEffect(26556950,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_CHAIN,0,1)
end
function c26556950.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetOverlayCount()>0 and ep~=tp and c:GetFlagEffect(26556950)~=0 and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c26556950.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,26556950)
	Duel.Damage(1-tp,600,REASON_EFFECT)
end
function c26556950.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c26556950.desfilter(c,def)
	return c:IsFaceup() and c:IsDefenseBelow(def)
end
function c26556950.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c26556950.desfilter,tp,0,LOCATION_MZONE,1,nil,c:GetDefense()) end
	local g=Duel.GetMatchingGroup(c26556950.desfilter,tp,0,LOCATION_MZONE,nil,c:GetDefense())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c26556950.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c26556950.desfilter,tp,0,LOCATION_MZONE,nil,c:GetDefense())
	Duel.Destroy(g,REASON_EFFECT)
end
