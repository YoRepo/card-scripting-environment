--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 极星灵 阿尔维斯  (ID: 27024795)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 1000
-- Setcode: 41026
--
-- Effect Text:
-- 这个卡名的②的效果在决斗中只能使用1次。
-- ①：「极星」连接怪兽的效果只让这张卡被除外的场合才能发动。等级合计直到10的「极星」怪兽从自己场上1只，从卡组2只送去墓地。那之后，从额外卡组把1只「极神」怪兽特殊召唤。
-- ②：自己的「极神」怪兽因战斗以外的方法被对方送去墓地的场合，把墓地的这张卡除外才能发动。同名卡不在自己墓地的1只「极神」怪兽从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--極星霊アルヴィース
function c27024795.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27024795,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_REMOVE)
	e1:SetRange(LOCATION_REMOVED)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c27024795.spcon)
	e1:SetTarget(c27024795.sptg)
	e1:SetOperation(c27024795.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27024795,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,27024795+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c27024795.spcon2)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c27024795.sptg2)
	e2:SetOperation(c27024795.spop2)
	c:RegisterEffect(e2)
end
function c27024795.spcon(e,tp,eg,ep,ev,re,r,rp)
	return #eg==1 and eg:GetFirst()==e:GetHandler() and re and re:IsActiveType(TYPE_LINK) and re:GetHandler():IsSetCard(0x42)
end
function c27024795.matfilter(c)
	return c:IsSetCard(0x42) and c:IsType(TYPE_MONSTER) and (c:IsFaceup() or c:IsLocation(LOCATION_DECK)) and c:IsLevelAbove(1)
end
function c27024795.fgoal(sg,e,tp)
	return sg:FilterCount(Card.IsLocation,nil,LOCATION_DECK)==2 and sg:GetSum(Card.GetLevel)==10
		and Duel.IsExistingMatchingCard(c27024795.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,sg)
end
function c27024795.spfilter(c,e,tp,mg)
	return c:IsSetCard(0x4b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mg,c)>0
end
function c27024795.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c27024795.matfilter,tp,LOCATION_DECK+LOCATION_MZONE,0,nil)
		return mg:CheckSubGroup(c27024795.fgoal,3,3,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,3,tp,LOCATION_DECK+LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c27024795.spop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(c27024795.matfilter,tp,LOCATION_DECK+LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=mg:SelectSubGroup(tp,c27024795.fgoal,false,3,3,e,tp)
	if sg and Duel.SendtoGrave(sg,REASON_EFFECT)==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=Duel.SelectMatchingCard(tp,c27024795.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
		if tg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c27024795.cfilter(c,tp)
	return c:IsPreviousSetCard(0x4b) and c:IsPreviousControler(tp)
end
function c27024795.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and eg:IsExists(c27024795.cfilter,1,nil,tp)
end
function c27024795.spfilter2(c,e,tp)
	return c:IsSetCard(0x4b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,c:GetCode())
end
function c27024795.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27024795.spfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c27024795.spop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c27024795.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
