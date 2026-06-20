--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 威风妖怪·蛤蟆  (ID: 645794)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L5 / R5
-- ATK 1300 | DEF 500
-- Setcode: 208
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- 【怪兽效果】
-- 「威风妖怪·蛤蟆」的①的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功时才能发动。从卡组选1张「威风妖怪」魔法·陷阱卡在自己场上盖放。这个效果盖放的卡在这个回合不能发动。
-- ②：这张卡只要在怪兽区域存在，不会成为对方的效果的对象，不会被对方的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--マジェスペクター・フロッグ
function c645794.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,645794)
	e2:SetTarget(c645794.settg)
	e2:SetOperation(c645794.setop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--cannot target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(aux.indoval)
	c:RegisterEffect(e5)
end
function c645794.filter(c)
	return c:IsSetCard(0xd0) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c645794.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c645794.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c645794.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c645794.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
