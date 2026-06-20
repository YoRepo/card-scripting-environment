--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 召唤兽 俄刻阿诺斯  (ID: 6772168)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Sea Serpent
-- Level 9
-- ATK 3000 | DEF 3000
-- Setcode: 244
--
-- Effect Text:
-- 「阿莱斯特」怪兽＋暗·水属性怪兽
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：只要这张卡在主要怪兽区域存在，对方怪兽不能选择其他怪兽作为攻击对象。
-- ②：只要这张卡在额外怪兽区域存在，被送去对方墓地的怪兽不去墓地而除外。
-- ③：把墓地的这张卡除外，以自己场上1只融合怪兽为对象才能发动。这个回合，那只怪兽可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--召喚獣オーケアノス
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1e1),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WATER+ATTRIBUTE_DARK),true)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetCondition(s.atcon)
	e1:SetValue(s.atlimit)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(LOCATION_REMOVED)
	e2:SetTargetRange(0,LOCATION_DECK)
	e2:SetCondition(s.rmcon)
	e2:SetTarget(s.rmtg)
	c:RegisterEffect(e2)
	--at
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,id)
	e3:SetCondition(aux.bpcon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(s.attg)
	e3:SetOperation(s.atop)
	c:RegisterEffect(e3)
end
function s.atcon(e)
	return e:GetHandler():GetSequence()<5
end
function s.atlimit(e,c)
	return c~=e:GetHandler()
end
function s.rmcon(e)
	return e:GetHandler():GetSequence()>4
end
function s.rmtg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer() and aux.DimensionalFissureTarget(e,c)
end
function s.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
		and not c:IsHasEffect(EFFECT_DIRECT_ATTACK) and not c:IsHasEffect(EFFECT_CANNOT_DIRECT_ATTACK)
end
function s.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function s.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToChain() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
