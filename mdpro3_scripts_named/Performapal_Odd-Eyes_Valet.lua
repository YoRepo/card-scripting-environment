--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 娱乐伙伴 异色眼贴身男仆  (ID: 82661461)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 1
-- Pendulum Scales: L8 / R8
-- ATK 100 | DEF 200
-- Setcode: 10027167
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：1回合1次，对方怪兽的攻击宣言时才能发动。那只对方怪兽的攻击力下降自己的额外卡组的表侧表示的灵摆怪兽数量×300。
-- 【怪兽效果】
-- 这个卡名的①的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把「娱乐伙伴 异色眼贴身男仆」以外的1只「娱乐伙伴」怪兽或者「异色眼」怪兽送去墓地。这张卡的等级直到回合结束时变成和送去墓地的怪兽的等级相同。
-- ②：怪兽区域的这张卡被破坏的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--EMオッドアイズ・バレット
function c82661461.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c82661461.atkcon)
	e1:SetTarget(c82661461.atktg)
	e1:SetOperation(c82661461.atkop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,82661461)
	e2:SetTarget(c82661461.tgtg)
	e2:SetOperation(c82661461.tgop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--pendulum
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c82661461.pencon)
	e4:SetTarget(c82661461.pentg)
	e4:SetOperation(c82661461.penop)
	c:RegisterEffect(e4)
end
function c82661461.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c82661461.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c82661461.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82661461.atkfilter,tp,LOCATION_EXTRA,0,1,nil) end
end
function c82661461.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=Duel.GetAttacker()
	local ct=Duel.GetMatchingGroupCount(c82661461.atkfilter,tp,LOCATION_EXTRA,0,nil)*300
	if bc:IsFaceup() and bc:IsRelateToBattle() and ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-ct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e1)
	end
end
function c82661461.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9f,0x99) and not c:IsCode(82661461) and c:IsAbleToGrave()
end
function c82661461.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82661461.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c82661461.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c82661461.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE)
		and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c82661461.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c82661461.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c82661461.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
