--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 喷水引擎  (ID: 7653207)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 450
--
-- Effect Text:
-- ①：以自己场上1只鱼族·海龙族·水族怪兽为对象才能发动。那只怪兽的攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--アクア・ジェット
function c7653207.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c7653207.target)
	e1:SetOperation(c7653207.activate)
	c:RegisterEffect(e1)
end
function c7653207.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
function c7653207.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c7653207.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7653207.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c7653207.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c7653207.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end
