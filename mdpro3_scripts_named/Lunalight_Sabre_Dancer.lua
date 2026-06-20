--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 月光舞剑虎姬  (ID: 88753594)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 9
-- ATK 3000 | DEF 2600
-- Setcode: 223
--
-- Effect Text:
-- 「月光」怪兽×3
-- 这张卡不用融合召唤不能特殊召唤。这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升双方的墓地·除外状态的兽战士族怪兽数量×200。
-- ②：对方不能把场上的这张卡作为效果的对象。
-- ③：把这个回合没有送去墓地的这张卡从墓地除外，以自己场上1只融合怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升3000。
--[[ __CARD_HEADER_END__ ]]

--月光舞剣虎姫
function c88753594.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xdf),3,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c88753594.atkval)
	c:RegisterEffect(e2)
	--cannot be targeted
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(88753594,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,88753594)
	e4:SetCondition(aux.exccon)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(c88753594.atktg)
	e4:SetOperation(c88753594.atkop)
	c:RegisterEffect(e4)
end
function c88753594.atkfilter1(c)
	return c:IsRace(RACE_BEASTWARRIOR) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c88753594.atkval(e,c)
	return Duel.GetMatchingGroupCount(c88753594.atkfilter1,c:GetControler(),LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,nil)*200
end
function c88753594.atkfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c88753594.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c88753594.atkfilter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88753594.atkfilter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c88753594.atkfilter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c88753594.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(3000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
