--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 黄金狂 黄金国巫妖  (ID: 74889525)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Zombie
-- Level 10
-- ATK 3800 | DEF 3500
-- Setcode: 4418
--
-- Effect Text:
-- 「黄金国巫妖」怪兽＋5星以上的不死族怪兽
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡只要在怪兽区域存在，卡名当作「黄金卿 黄金国巫妖」使用。
-- ②：场上的这张卡不会被战斗·效果破坏。
-- ③：把自己场上1只不死族怪兽解放，以对方场上1只表侧表示怪兽为对象才能发动。得到那只怪兽的控制权。那只怪兽直到回合结束时不能攻击，不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--黄金狂エルドリッチ
function c74889525.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1142),c74889525.matfilter,true)
	--change name
	aux.EnableChangeCode(c,95440946)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--control
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(74889525,0))
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,74889525)
	e4:SetCost(c74889525.ctcost)
	e4:SetTarget(c74889525.cttg)
	e4:SetOperation(c74889525.ctop)
	c:RegisterEffect(e4)
end
function c74889525.matfilter(c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_ZOMBIE)
end
function c74889525.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c74889525.rfilter(c,tp)
	return c:IsRace(RACE_ZOMBIE) and (c:IsControler(tp) or c:IsFaceup()) and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
		and Duel.IsExistingTarget(c74889525.ctfilter,tp,0,LOCATION_MZONE,1,c)
end
function c74889525.ctfilter(c)
	return c:IsFaceup() and c:IsAbleToChangeControler()
end
function c74889525.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c74889525.ctfilter(chkc) end
	if chk==0 then
		if e:GetLabel()==1 then
			e:SetLabel(0)
			return Duel.CheckReleaseGroup(tp,c74889525.rfilter,1,nil,tp)
		else
			return Duel.IsExistingTarget(c74889525.ctfilter,tp,0,LOCATION_MZONE,1,nil)
		end
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local sg=Duel.SelectReleaseGroup(tp,c74889525.rfilter,1,1,nil,tp)
		Duel.Release(sg,REASON_COST)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c74889525.ctfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c74889525.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.GetControl(tc,tp)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		tc:RegisterEffect(e2)
	end
end
