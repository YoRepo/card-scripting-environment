--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 百年龙  (ID: 90788081)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 4
-- ATK 1800 | DEF 1000
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，自己主要阶段才能发动。直到回合结束时，这张卡的等级上升自己场上的卡数量的数值，这张卡的攻击力上升所升数值×100。
-- ②：这张卡被送去墓地的场合，以从额外卡组特殊召唤的自己场上1只表侧表示怪兽为对象才能发动。那只怪兽只在场上表侧表示存在才有1次不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--百年竜
function c90788081.initial_effect(c)
	--lv/atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90788081,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c90788081.lvtg)
	e1:SetOperation(c90788081.lvop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90788081,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,90788081)
	e2:SetTarget(c90788081.indtg)
	e2:SetOperation(c90788081.indop)
	c:RegisterEffect(e2)
end
function c90788081.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLevelAbove(1) and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)>0 end
end
function c90788081.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lv=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
	if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsLevelAbove(1) and lv>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(lv*100)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
function c90788081.indfilter(c)
	return c:IsFaceup() and c:IsSummonLocation(LOCATION_EXTRA)
end
function c90788081.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c90788081.indfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90788081.indfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c90788081.indfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c90788081.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(90788081,2))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_NO_TURN_RESET)
		e1:SetRange(LOCATION_ONFIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetCountLimit(1)
		e1:SetValue(c90788081.indct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c90788081.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else
		return 0
	end
end
