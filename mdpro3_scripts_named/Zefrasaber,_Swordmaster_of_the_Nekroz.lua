--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 剑圣之影灵衣-神数剑士  (ID: 84388461)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L1 / R1
-- ATK 1500 | DEF 800
-- Setcode: 55846371524
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：自己不是「影灵衣」怪兽以及「神数」怪兽不能灵摆召唤。这个效果不会被无效化。
-- 【怪兽效果】
-- 「剑圣之影灵衣-神数剑士」的怪兽效果1回合只能使用1次。
-- ①：把自己的手卡·场上的这张卡解放才能发动。等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放，从手卡把1只「影灵衣」仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--剣聖の影霊衣－セフィラセイバー
function c84388461.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c84388461.splimit)
	c:RegisterEffect(e2)
	--spsummon
	local e3=aux.AddRitualProcEqual2(c,c84388461.filter,nil,nil,c84388461.mfilter,true)
	e3:SetDescription(aux.Stringid(84388461,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(0)
	e3:SetCountLimit(1,84388461)
	e3:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e3:SetCost(c84388461.cost)
	c:RegisterEffect(e3)
end
function c84388461.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb4,0xc4) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c84388461.filter(c)
	return c:IsSetCard(0xb4)
end
function c84388461.mfilter(c,e,tp,chk)
	return not chk or c~=e:GetHandler()
end
function c84388461.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
