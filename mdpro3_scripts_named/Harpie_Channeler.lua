--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鹰身通灵师  (ID: 90238142)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1400 | DEF 1300
-- Setcode: 100
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「鹰身女郎」使用。
-- ②：只要自己场上有龙族怪兽存在，这张卡的等级变成7星。
-- ③：从手卡丢弃1张「鹰身」卡才能发动。从卡组把「鹰身通灵师」以外的1只「鹰身」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・チャネラー
function c90238142.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90238142,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,90238142)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c90238142.spcost)
	e1:SetTarget(c90238142.sptg)
	e1:SetOperation(c90238142.spop)
	c:RegisterEffect(e1)
	--change name
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--change level
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c90238142.lvcon)
	e3:SetValue(7)
	c:RegisterEffect(e3)
end
function c90238142.cfilter(c)
	return c:IsSetCard(0x64) and c:IsDiscardable()
end
function c90238142.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90238142.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c90238142.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c90238142.filter(c,e,tp)
	return c:IsSetCard(0x64) and not c:IsCode(90238142) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c90238142.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90238142.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c90238142.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90238142.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c90238142.lvfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c90238142.lvcon(e)
	return Duel.IsExistingMatchingCard(c90238142.lvfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
