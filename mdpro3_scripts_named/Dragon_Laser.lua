--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 火龙镭射  (ID: 29228350)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上表侧表示存在的「三角三」装备的1只「三角火龙」送去墓地，对方场上存在的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンレーザー
function c29228350.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c29228350.target)
	e1:SetOperation(c29228350.activate)
	c:RegisterEffect(e1)
end
function c29228350.filter(c,tp)
	local ec=c:GetEquipTarget()
	return ec and c:IsCode(48568432) and ec:IsControler(tp) and ec:IsCode(12079734)
end
function c29228350.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c29228350.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c29228350.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,tp)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c29228350.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c29228350.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 then
		local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
