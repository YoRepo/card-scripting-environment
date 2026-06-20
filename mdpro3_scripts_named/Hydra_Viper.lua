--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 三头毒蛇  (ID: 37869028)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 4
-- ATK 1800 | DEF 400
--
-- Effect Text:
-- 这张卡在同1次的战斗阶段中可以作3次攻击。这张卡若不把自己场上存在的1只水族怪兽解放则不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--トリプル・ヴァイパー
function c37869028.initial_effect(c)
	--multiattack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	--attack cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_COST)
	e2:SetCost(c37869028.atcost)
	e2:SetOperation(c37869028.atop)
	c:RegisterEffect(e2)
end
function c37869028.atcost(e,c,tp)
	return Duel.CheckReleaseGroupEx(tp,Card.IsRace,1,REASON_ACTION,false,nil,RACE_AQUA)
end
function c37869028.atop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectReleaseGroupEx(tp,Card.IsRace,1,1,REASON_ACTION,false,nil,RACE_AQUA)
	Duel.Release(g,REASON_ACTION)
end
