--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 连接邮件盔甲恶魔  (ID: 68295149)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 2800 | LINK
-- Setcode: 69
--
-- Effect Text:
-- 包含仪式·融合·同调·超量怪兽其中任意种的怪兽2只以上
-- ①：这张卡特殊召唤成功的场合，以自己的场上·墓地1只仪式·融合·同调·超量怪兽为对象才能发动。对方场上的全部怪兽的攻击力直到回合结束时下降作为对象的怪兽的攻击力数值。
-- ②：从额外卡组特殊召唤的自己场上的怪兽不会成为对方怪兽的效果的对象。
-- ③：这张卡被战斗·效果破坏的场合，可以作为代替把自己墓地1只仪式·融合·同调·超量怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--リンクメイル・デーモン
function c68295149.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c68295149.lcheck)
	c:EnableReviveLimit()
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68295149,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c68295149.atktg)
	e1:SetOperation(c68295149.atkop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c68295149.tgtg)
	e2:SetValue(c68295149.tgval)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c68295149.reptg)
	c:RegisterEffect(e3)
end
function c68295149.lcheck(g)
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)
end
function c68295149.atkfilter(c)
	return c:GetAttack()>0 and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)
end
function c68295149.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c68295149.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c68295149.atkfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c68295149.atkfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
end
function c68295149.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or (tc:IsLocation(LOCATION_MZONE) and tc:IsFacedown()) then return end
	local atk=tc:GetAttack()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local sc=g:GetFirst()
	while sc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		sc:RegisterEffect(e1)
		sc=g:GetNext()
	end
end
function c68295149.tgtg(e,c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c68295149.tgval(e,re,rp)
	return rp==1-e:GetHandlerPlayer() and re:IsActiveType(TYPE_MONSTER)
end
function c68295149.repfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ) and c:IsAbleToRemove()
end
function c68295149.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and Duel.IsExistingMatchingCard(c68295149.repfilter,tp,LOCATION_GRAVE,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c68295149.repfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
