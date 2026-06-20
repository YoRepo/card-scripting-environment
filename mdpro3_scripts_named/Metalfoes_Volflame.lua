--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 炼装勇士·钨火  (ID: 69351984)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Psychic
-- Level 7
-- Pendulum Scales: L8 / R8
-- ATK 2400 | DEF 2000
-- Setcode: 225
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：1回合1次，以这张卡以外的自己场上1张表侧表示的卡为对象才能发动。那张卡破坏，从卡组选1张「炼装」魔法·陷阱卡在自己场上盖放。
-- 【怪兽描述】
-- 拥有赤热魂钢的上级战士。就在与将世界带向终结的红色真龙威胁进行对峙的时候，他得到仿佛彼此呼应而穿越次元出现的光之意志引导，使身披百炼钢甲之术迎来了绽放时刻。
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・ヴォルフレイム
function c69351984.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy and set
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c69351984.target)
	e1:SetOperation(c69351984.operation)
	c:RegisterEffect(e1)
end
function c69351984.desfilter(c,tp)
	if c:IsFacedown() then return false end
	return Duel.GetSZoneCount(tp,c)>0 and Duel.IsExistingMatchingCard(c69351984.filter,tp,LOCATION_DECK,0,1,nil,true)
end
function c69351984.filter(c,ignore)
	return c:IsSetCard(0xe1) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable(ignore)
end
function c69351984.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c69351984.desfilter(chkc,tp) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c69351984.desfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c69351984.desfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c69351984.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,c69351984.filter,tp,LOCATION_DECK,0,1,1,nil,false)
		if g:GetCount()>0 then
			Duel.SSet(tp,g:GetFirst())
		end
	end
end
