--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Iron Maiden  (ID: 211150)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Machine
-- Rank 8
-- ATK 0 | DEF 3000
-- Setcode: 0x95c (Crimsonheart)
--
-- Materials: 2 Level 8 monsters
--
-- Effect Text:
-- While you control "Barren Lady Lacrimosaica", you can also Xyz Summon this card to your opponent's
-- field using 1 monster they control. You can only Special Summon "Crimsonheart Iron Maiden(s)" once
-- per turn. You can only use the (2) effect of "Crimsonheart Iron Maiden" once per turn.
-- (1) After this card is Special Summoned, change it to Defense Position.
-- (2) When your opponent activates a monster effect in the GY while this card is in your GY (Quick
-- Effect): You can banish this; negate the activation, and if you do, banish that card.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Iron Maiden
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	c:SetSPSummonOnce(id)
	c:EnableReviveLimit()
	--Xyz: 2 Level 8 monsters
	aux.AddXyzProcedure(c,nil,8,2)
	--custom proc: while you control Lacrimosaica, Xyz Summon this card TO YOUR OPPONENT'S FIELD by
	--overlaying 1 monster they control (EFFECT_FLAG_SPSUM_PARAM + SetTargetRange(pos,1) places it on their field)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SPSUM_PARAM)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetTargetRange(POS_FACEUP_ATTACK,1)
	e0:SetCondition(s.xyzcon)
	e0:SetOperation(s.xyzop)
	c:RegisterEffect(e0)
	--(1) after this card is Special Summoned, change it to Defense Position
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(s.posop)
	c:RegisterEffect(e1)
	--(2) (Quick Effect) from GY: when opponent activates a monster effect in the GY; banish this, negate & banish
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.discon)
	e2:SetCost(s.discost)
	e2:SetTarget(s.distg)
	e2:SetOperation(s.disop)
	c:RegisterEffect(e2)
end
--alternative Xyz Summon: while you control Lacrimosaica, overlay 1 monster your opponent controls and
--Xyz Summon this card onto their field (the freed material zone always leaves room for this card)
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.matfilter(c,tp)
	return c:IsFaceup() and c:IsCanOverlay() and Duel.GetMZoneCount(1-tp,c,tp)>0
end
function s.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.matfilter,tp,0,LOCATION_MZONE,1,nil,tp)
end
function s.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,s.matfilter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
--(1) change this card to Defense Position after it is Special Summoned (works on either field, non-chaining)
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
--(2)
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
		and loc&LOCATION_GRAVE~=0
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() end
	Duel.Remove(c,POS_FACEUP,REASON_COST)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToRemove() then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsAbleToRemove() then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
