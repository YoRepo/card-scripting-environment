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
-- While you control "Barren Lady Lacrimosaica", you can also Xyz Summon this card using 1 monster
-- your opponent controls. You can only Special Summon "Crimsonheart Iron Maiden(s)" once per turn.
-- You can only use the (2) effect of "Crimsonheart Iron Maiden" once per turn.
-- (1) Your opponent cannot target monsters you control for attacks, except "Crimsonheart Iron Maiden".
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
	--custom proc: while you control Lacrimosaica, Xyz Summon by overlaying onto 1 monster your opponent controls
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(s.xyzcon)
	e0:SetOperation(s.xyzop)
	c:RegisterEffect(e0)
	--(1) opponent cannot target monsters you control for attacks, except this card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(s.atklimit)
	c:RegisterEffect(e1)
	--(2) (Quick Effect) from GY: when opponent activates a monster effect in the GY; banish this, negate & banish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,id)
	e3:SetCondition(s.discon)
	e3:SetCost(s.discost)
	e3:SetTarget(s.distg)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
end
--alternative Xyz Summon: overlay onto 1 monster your opponent controls, while you control Lacrimosaica
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.matfilter(c)
	return c:IsFaceup() and c:IsCanOverlay()
end
function s.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.matfilter,tp,0,LOCATION_MZONE,1,nil)
end
function s.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,s.matfilter,tp,0,LOCATION_MZONE,1,1,nil)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
--(1) monsters you control other than this card cannot be selected as attack targets
function s.atklimit(e,c)
	return not c:IsCode(id)
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
