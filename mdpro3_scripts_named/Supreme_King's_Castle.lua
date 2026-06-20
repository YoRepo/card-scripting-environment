--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 霸王城  (ID: 72043279)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在场地区域存在，自己对用「暗黑融合」的效果才能特殊召唤的融合怪兽用「暗黑融合」的效果以外也能融合召唤。
-- ②：1回合1次，自己的恶魔族怪兽和对方怪兽进行战斗的伤害计算时，从卡组·额外卡组把1只「邪心英雄」怪兽送去墓地才能发动。那只自己怪兽的攻击力直到回合结束时上升送去墓地的怪兽的等级×200。
--[[ __CARD_HEADER_END__ ]]

--覇王城
function c72043279.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--fusion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(72043279)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(72043279,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCountLimit(1)
	e3:SetCondition(c72043279.atkcon)
	e3:SetCost(c72043279.atkcost)
	e3:SetOperation(c72043279.atkop)
	c:RegisterEffect(e3)
end
function c72043279.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then tc=bc end
	e:SetLabelObject(tc)
	return tc:IsFaceup() and tc:IsRace(RACE_FIEND)
end
function c72043279.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x6008) and c:IsLevelAbove(0) and c:IsAbleToGraveAsCost()
end
function c72043279.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72043279.atkfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c72043279.atkfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c72043279.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsFaceup() and tc:IsControler(tp) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
