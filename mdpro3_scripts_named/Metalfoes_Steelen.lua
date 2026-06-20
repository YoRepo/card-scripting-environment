--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 炼装勇士·钢人  (ID: 60473572)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Psychic
-- Level 2
-- Pendulum Scales: L8 / R8
-- ATK 0 | DEF 2100
-- Setcode: 225
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：1回合1次，以这张卡以外的自己场上1张表侧表示的卡为对象才能发动。那张卡破坏，从卡组选1张「炼装」魔法·陷阱卡在自己场上盖放。
-- 【怪兽描述】
-- 当隐藏于黑铁机身中的灵魂觉醒之时，钢铁将升华化作秘金属，成为人机一体的勇士。令刻于其身的魂钢燃烧起来吧！——炼装融合！！
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・スティエレン
function c60473572.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy and set
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c60473572.target)
	e1:SetOperation(c60473572.operation)
	c:RegisterEffect(e1)
end
function c60473572.desfilter(c,tp)
	if c:IsFacedown() then return false end
	return Duel.GetSZoneCount(tp,c)>0 and Duel.IsExistingMatchingCard(c60473572.filter,tp,LOCATION_DECK,0,1,nil,true)
end
function c60473572.filter(c,ignore)
	return c:IsSetCard(0xe1) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable(ignore)
end
function c60473572.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c60473572.desfilter(chkc,tp) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c60473572.desfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c60473572.desfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c60473572.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,c60473572.filter,tp,LOCATION_DECK,0,1,1,nil,false)
		if g:GetCount()>0 then
			Duel.SSet(tp,g:GetFirst())
		end
	end
end
