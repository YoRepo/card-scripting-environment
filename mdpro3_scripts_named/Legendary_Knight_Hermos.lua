--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 传说的骑士 赫谟  (ID: 84565800)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Warrior
-- Level 8
-- ATK 2800 | DEF 1800
-- Setcode: 160
--
-- Effect Text:
-- 这张卡不能通常召唤。「传说之心」的效果才能特殊召唤。
-- ①：这张卡特殊召唤成功时，以场上1张表侧表示的魔法·陷阱卡为对象才能发动。那张表侧表示的魔法·陷阱卡除外。
-- ②：1回合1次，这张卡被选择作为攻击对象时，以自己墓地1只效果怪兽为对象才能发动。这张卡直到下次的自己回合的结束阶段当作和那只墓地的怪兽同名卡使用，得到相同效果。
--[[ __CARD_HEADER_END__ ]]

--伝説の騎士 ヘルモス
function c84565800.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84565800,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetTarget(c84565800.rmtg)
	e2:SetOperation(c84565800.rmop)
	c:RegisterEffect(e2)
	--copy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84565800,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c84565800.cptg)
	e3:SetOperation(c84565800.cpop)
	c:RegisterEffect(e3)
end
function c84565800.rmfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove() and c:IsFaceup()
end
function c84565800.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c84565800.rmfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84565800.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c84565800.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c84565800.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsType(TYPE_SPELL+TYPE_TRAP) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c84565800.cpfilter(c)
	return c:IsType(TYPE_EFFECT)
end
function c84565800.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c84565800.cpfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84565800.cpfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c84565800.cpfilter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c84565800.cpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and c:IsFaceup() and c:IsRelateToEffect(e) then
		local code=tc:GetCode()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		c:RegisterEffect(e1)
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
	end
end
