--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 德拉科尼亚的翼龙骑兵  (ID: 68182934)
-- Type: Monster / Normal / Pendulum
-- Attribute: WIND
-- Race: Winged Beast
-- Level 5
-- Pendulum Scales: L7 / R7
-- ATK 2200 | DEF 200
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：1回合1次，自己的通常怪兽给与对方战斗伤害时，以场上1张卡为对象才能发动。那张卡破坏。
-- 【怪兽描述】
-- 龙人族国家德拉科尼亚帝国所拥有的龙骑士团空兵部队。有传闻说是为了对空中都市国家苏鲁伯这个中立国进行入侵而结成，使得周边国家对此加强警戒。
--[[ __CARD_HEADER_END__ ]]

--ドラコニアの翼竜騎兵
function c68182934.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c68182934.descon)
	e2:SetTarget(c68182934.destg)
	e2:SetOperation(c68182934.desop)
	c:RegisterEffect(e2)
end
function c68182934.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsControler(tp) and tc:IsType(TYPE_NORMAL)
end
function c68182934.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c68182934.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
