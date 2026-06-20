--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 鰤子姬  (ID: 6625096)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功时，把这张卡除外才能发动。从卡组把「鰤子姬」以外的1只4星以下的鱼族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--鰤っ子姫
function c6625096.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6625096,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,6625096)
	e1:SetCost(c6625096.spcost)
	e1:SetTarget(c6625096.sptg)
	e1:SetOperation(c6625096.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c6625096.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c6625096.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_FISH) and not c:IsCode(6625096) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6625096.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c6625096.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c6625096.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c6625096.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
