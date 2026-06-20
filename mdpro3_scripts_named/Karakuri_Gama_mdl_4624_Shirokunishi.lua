--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 机巧蛤蟆 四六二四  (ID: 75690317)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 200 | DEF 1000
-- Setcode: 17
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡可以攻击的场合必须作出攻击。
-- ②：这张卡被选择作为攻击对象的场合发动。这张卡的表示形式变更。
-- ③：把墓地的这张卡除外，以自己场上1只「机巧」怪兽为对象才能发动。那只怪兽的表示形式变更。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--カラクリ蝦蟇 四六弐四
function c75690317.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--position change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75690317,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetOperation(c75690317.posop1)
	c:RegisterEffect(e2)
	--position change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75690317,1))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,75690317)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c75690317.postg1)
	e3:SetOperation(c75690317.posop2)
	c:RegisterEffect(e3)
end
function c75690317.posop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
function c75690317.posfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11) and c:IsCanChangePosition()
end
function c75690317.postg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75690317.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75690317.posfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c75690317.posfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c75690317.posop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
