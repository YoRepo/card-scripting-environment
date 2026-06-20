--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 亚马逊宠物虎狮王  (ID: 59353647)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level 9
-- ATK 2900 | DEF 2800
-- Setcode: 4
--
-- Effect Text:
-- 5星以上的「亚马逊」怪兽＋「亚马逊」怪兽
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，对方怪兽不能向这张卡以外的怪兽攻击。
-- ②：以自己场上1张「亚马逊」卡和自己墓地1只战士族「亚马逊」怪兽为对象才能发动。作为对象的场上的卡破坏，作为对象的墓地的怪兽特殊召唤。这个效果发动的回合，这张卡不能攻击。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスペット虎獅王
function c59353647.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c59353647.matfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0x4),true)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c59353647.atlimit)
	c:RegisterEffect(e1)
	--destroy and spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,59353647)
	e2:SetCost(c59353647.cost)
	e2:SetTarget(c59353647.target)
	e2:SetOperation(c59353647.operation)
	c:RegisterEffect(e2)
end
function c59353647.matfilter(c)
	return c:IsLevelAbove(5) and c:IsFusionSetCard(0x4)
end
function c59353647.atlimit(e,c)
	return c~=e:GetHandler()
end
function c59353647.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1,true)
end
function c59353647.desfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x4) and Duel.GetMZoneCount(tp,c)>0
end
function c59353647.spfilter(c,e,tp)
	return c:IsSetCard(0x4) and c:IsRace(RACE_WARRIOR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c59353647.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(c59353647.desfilter,tp,LOCATION_ONFIELD,0,1,nil,tp)
		and Duel.IsExistingTarget(c59353647.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c59353647.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c59353647.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g2,1,0,0)
	e:SetLabelObject(g1:GetFirst())
end
function c59353647.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc1,tc2=Duel.GetFirstTarget()
	if tc1~=e:GetLabelObject() then tc1,tc2=tc2,tc1 end
	if tc1:IsRelateToEffect(e) and Duel.Destroy(tc1,REASON_EFFECT)>0 and tc2:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP)
	end
end
