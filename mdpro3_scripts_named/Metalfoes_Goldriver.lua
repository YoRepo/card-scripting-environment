--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 炼装勇士·金驰  (ID: 33256280)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Psychic
-- Level 4
-- Pendulum Scales: L1 / R1
-- ATK 1900 | DEF 500
-- Setcode: 225
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，以这张卡以外的自己场上1张表侧表示的卡为对象才能发动。那张卡破坏，从卡组选1张「炼装」魔法·陷阱卡在自己场上盖放。
-- 【怪兽描述】
-- 闪耀着黄金车身的光芒，以豪爽的漂移跑法横扫敌军。尽管经常都很夸张地出现侧滑失控，但本人坚定立场地表示那就是必杀技。
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・ゴルドライバー
function c33256280.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy and set
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c33256280.target)
	e1:SetOperation(c33256280.operation)
	c:RegisterEffect(e1)
end
function c33256280.desfilter(c,tp)
	if c:IsFacedown() then return false end
	return Duel.GetSZoneCount(tp,c)>0 and Duel.IsExistingMatchingCard(c33256280.filter,tp,LOCATION_DECK,0,1,nil,true)
end
function c33256280.filter(c,ignore)
	return c:IsSetCard(0xe1) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable(ignore)
end
function c33256280.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c33256280.desfilter(chkc,tp) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33256280.desfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33256280.desfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33256280.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,c33256280.filter,tp,LOCATION_DECK,0,1,1,nil,false)
		if g:GetCount()>0 then
			Duel.SSet(tp,g:GetFirst())
		end
	end
end
