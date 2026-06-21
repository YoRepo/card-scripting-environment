--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Haunted Piano  (ID: 211090)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 0 | DEF 2100
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- You can only use the (1) effect of "Crimsonheart Haunted Piano" per turn and only once that turn.
-- (1) When you activate a Spell/Trap or effect while this card is in your GY, OR when your opponent
-- activates a Spell/Trap or effect while you control "Barren Lady Lacrimosaica" and this card is in
-- your GY: You can Special Summon this card, and if you do, negate the activation and destroy that card.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Haunted Piano
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	--(1a) from GY: when YOU activate a Spell/Trap or effect; SS this card, then negate & destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.negcon1)
	e1:SetTarget(s.negtg)
	e1:SetOperation(s.negop)
	c:RegisterEffect(e1)
	--(1b) from GY: when your OPPONENT activates a Spell/Trap or effect & you control Lacrimosaica
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCondition(s.negcon2)
	c:RegisterEffect(e2)
end
function s.negcon1(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.IsChainNegatable(ev)
end
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.negcon2(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end
