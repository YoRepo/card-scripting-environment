--[[ __CARD_HEADER_START__ ]]
-- Card: Crimsonheart Blood Sorrow  (ID: 211200)
-- Type: Trap
--
-- Effect Text:
-- You can only use each effect of “Crimsonheart Blood Sorrow” once per turn.
-- ① Special Summon 1 “Barren Lady Lacrimosaica” from your Deck.
-- ② If this card is in your GY: You can target 1 “Barren Lady Lacrimosaica” you control or in your GY; Special Summon this card as a Normal Monster (Illusion/DARK/Level 8/ATK 2200/DEF 2800) (this card is NOT treated as a Trap), and if you do, return that target to the hand.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Blood Sorrow
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	--(1) Activate: Special Summon 1 "Barren Lady Lacrimosaica" from your Deck
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCountLimit(1,id)
	e0:SetTarget(s.target)
	e0:SetOperation(s.activate)
	c:RegisterEffect(e0)
	--(2) (Quick Effect) from GY: target 1 "Barren Lady Lacrimosaica" you control or in your GY;
	--    Special Summon this card as a Normal Monster (NOT treated as a Trap), then return that target to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,4))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,id+o)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
--(1)
function s.filter(c,e,tp)
	return c:IsCode(211000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
--(2)
function s.lacfilter(c)
	return c:IsCode(211000) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and s.lacfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id,0x95c,TYPES_NORMAL_TRAP_MONSTER,2200,2800,8,RACE_ILLUSION,ATTRIBUTE_DARK)
		and Duel.IsExistingTarget(s.lacfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,s.lacfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if c:IsRelateToEffect(e)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id,0x95c,TYPES_NORMAL_TRAP_MONSTER,2200,2800,8,RACE_ILLUSION,ATTRIBUTE_DARK) then
		c:AddMonsterAttribute(TYPE_NORMAL)
		if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0
			and tc:IsRelateToEffect(e) and tc:IsControler(tp) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
