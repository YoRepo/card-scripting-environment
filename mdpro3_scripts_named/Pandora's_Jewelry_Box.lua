--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 潘德拉宝具箱  (ID: 15936370)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Wyrm
-- Level 4
-- Pendulum Scales: L4 / R4
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- ←4 【灵摆】 4→
-- ①：自己的额外卡组没有卡存在的场合，以对方的灵摆区域1张卡为对象才能发动。那张卡破坏，灵摆区域的这张卡在对方的灵摆区域放置。
-- 【怪兽效果】
-- ①：只要自己的额外卡组没有卡存在并有这张卡在怪兽区域存在，自己抽卡阶段的通常抽卡变成2张。
--[[ __CARD_HEADER_END__ ]]

--パンドラの宝具箱
function c15936370.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pendulum set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15936370,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c15936370.pencon)
	e1:SetTarget(c15936370.pentg)
	e1:SetOperation(c15936370.penop)
	c:RegisterEffect(e1)
	--effect draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(2)
	e2:SetCondition(c15936370.drcon)
	c:RegisterEffect(e2)
end
function c15936370.pencon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)==0
end
function c15936370.pentg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_PZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_PZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c15936370.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.MoveToField(c,tp,1-tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
function c15936370.drcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_EXTRA,0)==0
end
