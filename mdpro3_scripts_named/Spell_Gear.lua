--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔法齿车  (ID: 313513)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：把自己场上3张表侧表示的「古代的机械」卡送去墓地才能发动。从手卡以及卡组各把最多1只「古代的机械巨人」无视召唤条件特殊召唤。那之后，自己场上有「古代的机械巨人」以外的怪兽存在的场合，那些怪兽全部破
-- 坏。这个效果的发动后，用自己回合计算的2回合内，自己不能通常召唤。
--[[ __CARD_HEADER_END__ ]]

--魔法の歯車
function c313513.initial_effect(c)
	aux.AddCodeList(c,83104731)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c313513.cost)
	e1:SetTarget(c313513.target)
	e1:SetOperation(c313513.activate)
	c:RegisterEffect(e1)
end
function c313513.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x7) and c:IsAbleToGraveAsCost()
end
function c313513.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetMatchingGroup(c313513.cfilter,tp,LOCATION_ONFIELD,0,nil)
	if chk==0 then
		e:SetLabel(1)
		return tg:CheckSubGroup(aux.mzctcheck,3,3,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=tg:SelectSubGroup(tp,aux.mzctcheck,false,3,3,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c313513.filter(c,e,tp)
	return c:IsCode(83104731) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c313513.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c313513.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c313513.dfilter(c)
	return c:IsFacedown() or not c:IsCode(83104731)
end
function c313513.fselect(g)
	return g:GetClassCount(Card.GetLocation)==g:GetCount()
end
function c313513.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=math.min((Duel.GetLocationCount(tp,LOCATION_MZONE)),2)
	local g=Duel.GetMatchingGroup(c313513.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	if ft>0 and g:GetCount()>0 then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:SelectSubGroup(tp,c313513.fselect,false,1,ft)
		if sg and Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)>0 then
			local dg=Duel.GetMatchingGroup(c313513.dfilter,tp,LOCATION_MZONE,0,nil)
			if dg:GetCount()>0 then
				Duel.BreakEffect()
				Duel.Destroy(dg,REASON_EFFECT)
			end
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_SELF_TURN+RESET_PHASE+PHASE_END,2)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
end
