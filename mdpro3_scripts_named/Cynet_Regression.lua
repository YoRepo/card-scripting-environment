--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电脑网回归  (ID: 19943114)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己对连接怪兽的特殊召唤成功的场合，以场上1张卡为对象才能发动。那张卡破坏。那之后，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・リグレッション
function c19943114.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,19943114+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c19943114.condition)
	e1:SetTarget(c19943114.target)
	e1:SetOperation(c19943114.activate)
	c:RegisterEffect(e1)
end
function c19943114.cfilter(c,tp)
	return c:IsType(TYPE_LINK) and c:IsSummonPlayer(tp)
end
function c19943114.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c19943114.cfilter,1,nil,tp)
end
function c19943114.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c19943114.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
