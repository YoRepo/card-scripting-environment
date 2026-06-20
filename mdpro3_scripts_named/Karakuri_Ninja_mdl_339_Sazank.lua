--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 机巧忍者 三三九  (ID: 93724592)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 1200 | DEF 1200
-- Setcode: 2818065
--
-- Effect Text:
-- 这张卡可以攻击的场合必须作出攻击。场上表侧攻击表示存在的这张卡被选择作为攻击对象时，这张卡的表示形式变成守备表示。这张卡反转时，选择场上表侧表示存在的1只怪兽送去墓地。此外，这张卡反转的回合，这张卡可
-- 以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--カラクリ忍者 参参九
function c93724592.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--to defense
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(93724592,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(c93724592.poscon)
	e3:SetOperation(c93724592.posop)
	c:RegisterEffect(e3)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(93724592,1))
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetCode(EVENT_FLIP)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetTarget(c93724592.tgtg)
	e4:SetOperation(c93724592.tgop)
	c:RegisterEffect(e4)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_FLIP)
	e5:SetOperation(c93724592.dirop)
	c:RegisterEffect(e5)
end
function c93724592.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c93724592.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c93724592.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c93724592.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
function c93724592.dirop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
