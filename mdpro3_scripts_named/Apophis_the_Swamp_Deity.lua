--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 淀神 阿匹卜  (ID: 85888377)
-- Type: Trap / Equip
-- Attribute: EARTH
-- Race: Reptile
-- Level 6
-- ATK 2000 | DEF 2200
-- Setcode: 456
--
-- Effect Text:
-- ①：自己·对方的主要阶段才能把这张卡发动。这张卡变成通常怪兽（爬虫类族·地·6星·攻2000/守2200）在怪兽区域特殊召唤（也当作陷阱卡使用）。那之后，自己场上有其他的永续陷阱卡存在的场合，可以让最
-- 多有那个数量的对方场上的表侧表示卡的效果直到回合结束时无效。
--[[ __CARD_HEADER_END__ ]]

--澱神アポピス
function c85888377.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c85888377.condition)
	e1:SetTarget(c85888377.target)
	e1:SetOperation(c85888377.activate)
	c:RegisterEffect(e1)
end
function c85888377.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c85888377.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,85888377,0,TYPES_NORMAL_TRAP_MONSTER,2000,2200,6,RACE_REPTILE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c85888377.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS)
end
function c85888377.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,85888377,0,TYPES_NORMAL_TRAP_MONSTER,2000,2200,6,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP)
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
		local ct=Duel.GetMatchingGroupCount(c85888377.filter,tp,LOCATION_ONFIELD,0,c)
		local g=Duel.GetMatchingGroup(aux.NegateAnyFilter,tp,0,LOCATION_ONFIELD,nil)
		if ct>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(85888377,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
			local sg=g:Select(tp,1,ct,nil)
			Duel.HintSelection(sg)
			for tc in aux.Next(sg) do
				Duel.NegateRelatedChain(tc,RESET_TURN_SET)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetCode(EFFECT_DISABLE)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_DISABLE_EFFECT)
				e2:SetValue(RESET_TURN_SET)
				tc:RegisterEffect(e2)
				if tc:IsType(TYPE_TRAPMONSTER) then
					local e3=e1:Clone()
					e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
					tc:RegisterEffect(e3)
				end
			end
		end
	end
end
