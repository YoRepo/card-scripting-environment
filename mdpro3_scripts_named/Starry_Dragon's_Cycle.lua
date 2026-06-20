--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 星宵龙转  (ID: 6278008)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以场上1只融合·同调·超量·连接怪兽为对象才能发动。那只表侧表示怪兽回到额外卡组。那之后，可以把回去的怪兽种类（融合·同调·超量·连接）对应的1只以下怪兽从自己·对方的墓地往自己场上特殊召唤。
-- ●融合：和回去的怪兽相同属性的怪兽
-- ●同调：比回去的怪兽等级低的怪兽
-- ●超量：持有和回去的怪兽的阶级相同数值的等级的怪兽
-- ●连接：和回去的怪兽相同种族的怪兽
--[[ __CARD_HEADER_END__ ]]

--星宵竜転
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK) and c:IsAbleToExtra()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
end
function s.sfilter(c,e,tp,f)
	return f(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0) then return end
	local f=aux.FALSE
	local typ=tc:GetType()&TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK
	if typ==TYPE_FUSION then f=aux.FilterEqualFunction(Card.GetAttribute,tc:GetAttribute())
	elseif typ==TYPE_SYNCHRO then f=aux.FilterBoolFunction(Card.IsLevelBelow,tc:GetLevel()-1)
	elseif typ==TYPE_XYZ then f=aux.FilterBoolFunction(Card.IsLevel,tc:GetRank())
	elseif typ==TYPE_LINK then f=aux.FilterEqualFunction(Card.GetRace,tc:GetRace()) end
	local g=Duel.GetMatchingGroup(s.sfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e,tp,f)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
