--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 电子龙·凯旋  (ID: 46724542)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Machine
-- ATK 2100 | LINK
-- Setcode: 4243
--
-- Effect Text:
-- 包含「电子龙」的机械族怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「电子龙」使用。
-- ②：这张卡没有攻击宣言的自己·对方的战斗阶段，以自己场上1只攻击力2100以上的机械族怪兽为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时上升2100。这个效果的发动后，直到回合结束时这张卡的战
-- 斗的双方的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--サイバー・ドラゴン・ズィーガー
function c46724542.initial_effect(c)
	aux.AddMaterialCodeList(c,70095154)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_MACHINE),2,2,c46724542.lcheck)
	--code
	aux.EnableChangeCode(c,70095154,LOCATION_MZONE+LOCATION_GRAVE)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46724542,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1,46724542)
	e2:SetCondition(c46724542.condition)
	e2:SetTarget(c46724542.target)
	e2:SetOperation(c46724542.operation)
	c:RegisterEffect(e2)
end
function c46724542.lcheck(g,lc)
	return g:IsExists(Card.IsLinkCode,1,nil,70095154)
end
function c46724542.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
		and aux.dscon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():GetAttackAnnouncedCount()<1
end
function c46724542.filter(c)
	return c:IsFaceup() and c:IsAttackAbove(2100) and c:IsRace(RACE_MACHINE)
end
function c46724542.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c46724542.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46724542.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c46724542.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c46724542.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(2100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
	if c:IsRelateToEffect(e) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e4:SetValue(1)
		c:RegisterEffect(e4)
	end
end
