--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 战神-不知火  (ID: 83283063)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Zombie
-- Level 8
-- ATK 3000 | DEF 0
-- Setcode: 217
--
-- Effect Text:
-- 不死族调整＋调整以外的不死族怪兽1只以上
-- 自己对「战神-不知火」1回合只能有1次特殊召唤。
-- ①：这张卡特殊召唤成功的场合，从自己墓地把1只不死族怪兽除外才能发动。这张卡的攻击力直到回合结束时上升除外的怪兽的原本攻击力数值。
-- ②：场上的这张卡被战斗·效果破坏送去墓地的场合，以除外的1只自己的守备力0的不死族怪兽为对象才能发动。那只怪兽回到墓地。
--[[ __CARD_HEADER_END__ ]]

--戦神－不知火
function c83283063.initial_effect(c)
	c:SetSPSummonOnce(83283063)
	--synchro summon
	aux.AddSynchroProcedure(c,c83283063.synfilter,aux.NonTuner(c83283063.synfilter),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83283063,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCost(c83283063.cost)
	e1:SetOperation(c83283063.operation)
	c:RegisterEffect(e1)
	--add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83283063,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c83283063.tgcon)
	e2:SetTarget(c83283063.tgtg)
	e2:SetOperation(c83283063.tgop)
	c:RegisterEffect(e2)
end
function c83283063.synfilter(c)
	return c:IsRace(RACE_ZOMBIE)
end
function c83283063.cfilter(c)
	return c:IsRace(RACE_ZOMBIE) and c:GetBaseAttack()>0 and c:IsAbleToRemoveAsCost()
end
function c83283063.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c83283063.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c83283063.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetBaseAttack())
end
function c83283063.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c83283063.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c83283063.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsDefense(0)
end
function c83283063.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c83283063.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c83283063.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c83283063.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c83283063.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
	end
end
