--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 秘旋谍装备-无人机  (ID: 4474060)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 4334
--
-- Effect Text:
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从对方卡组上面把3张卡确认，用喜欢的顺序回到卡组上面。
-- ②：把这张卡解放，以自己场上1只「秘旋谍」怪兽为对象才能发动。那只怪兽的攻击力上升对方场上的卡数量×500。这个效果在对方回合也能发动。
-- ③：从自己墓地把这张卡和1张「秘旋谍」卡除外，以自己墓地1只「秘旋谍-花公子」为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--SPYRAL GEAR－ドローン
function c4474060.initial_effect(c)
	--sort
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4474060,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c4474060.sttg)
	e1:SetOperation(c4474060.stop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4474060,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetCondition(aux.dscon)
	e3:SetCost(c4474060.atkcost)
	e3:SetTarget(c4474060.atktg)
	e3:SetOperation(c4474060.atkop)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4474060,2))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCost(c4474060.thcost)
	e4:SetTarget(c4474060.thtg)
	e4:SetOperation(c4474060.thop)
	c:RegisterEffect(e4)
end
function c4474060.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function c4474060.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,1-tp,3)
end
function c4474060.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c4474060.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xee)
end
function c4474060.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c4474060.atkfilter(chkc) end
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 and
		Duel.IsExistingTarget(c4474060.atkfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c4474060.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c4474060.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)*500
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c4474060.cfilter(c,tp)
	return c:IsSetCard(0xee) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingTarget(c4474060.thfilter,tp,LOCATION_GRAVE,0,1,c)
end
function c4474060.thfilter(c)
	return c:IsCode(41091257) and c:IsAbleToHand()
end
function c4474060.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c4474060.cfilter,tp,LOCATION_GRAVE,0,1,c,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c4474060.cfilter,tp,LOCATION_GRAVE,0,1,1,c,tp)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c4474060.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c4474060.thfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c4474060.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c4474060.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
