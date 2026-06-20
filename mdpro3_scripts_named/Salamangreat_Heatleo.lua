--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 转生炎兽 炽热多头狮  (ID: 41463181)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Cyberse
-- ATK 2300 | LINK
-- Setcode: 281
--
-- Effect Text:
-- 炎属性效果怪兽2只以上
-- ①：这张卡连接召唤的场合，以对方的魔法与陷阱区域1张卡为对象才能发动。那张卡回到卡组。
-- ②：这张卡是已用「转生炎兽 炽热多头狮」为素材作连接召唤的场合，1回合1次，以场上1只表侧表示怪兽和自己墓地1只怪兽为对象才能发动。作为对象的场上的怪兽的攻击力直到回合结束时变成和作为对象的墓地的怪兽
-- 的攻击力相同。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣ヒートライオ
function c41463181.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c41463181.matfilter,2)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41463181,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c41463181.tdcon)
	e1:SetTarget(c41463181.tdtg)
	e1:SetOperation(c41463181.tdop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCondition(c41463181.condition)
	e2:SetOperation(c41463181.operation)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c41463181.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c41463181.matfilter(c)
	return c:IsLinkType(TYPE_EFFECT) and c:IsLinkAttribute(ATTRIBUTE_FIRE)
end
function c41463181.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c41463181.tdfilter(c)
	return c:GetSequence()<5 and c:IsAbleToDeck()
end
function c41463181.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c41463181.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c41463181.tdfilter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c41463181.tdfilter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c41463181.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c41463181.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) and e:GetLabel()==1
end
function c41463181.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41463181,1))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c41463181.atktg)
	e1:SetOperation(c41463181.atkop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c41463181.atkfilter1(c,tp)
	return c:IsFaceup() and Duel.IsExistingTarget(c41463181.atkfilter2,tp,LOCATION_GRAVE,0,1,nil,c)
end
function c41463181.atkfilter2(c,tc)
	return c:IsType(TYPE_MONSTER) and c:GetAttack()~=tc:GetAttack() and c:GetTextAttack()>=0
end
function c41463181.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c41463181.atkfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c41463181.atkfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c41463181.atkfilter2,tp,LOCATION_GRAVE,0,1,1,nil,g:GetFirst())
end
function c41463181.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sc=g:GetFirst()
	if sc==tc then sc=g:GetNext() end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or not sc:IsRelateToEffect(e) then return end
	local ac=e:GetLabelObject()
	if tc==ac then tc=sc end
	local atk=tc:GetAttack()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	ac:RegisterEffect(e1)
end
function c41463181.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsLinkCode,1,nil,41463181) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
