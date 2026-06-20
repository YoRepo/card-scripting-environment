--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 机壳工具 丑恶  (ID: 65518099)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- Pendulum Scales: L9 / R9
-- ATK 1000 | DEF 2800
-- Setcode: 170
--
-- Effect Text:
-- ←9 【灵摆】 9→
-- ①：自己不是「机壳」怪兽不能特殊召唤。这个效果不会被无效化。
-- ②：1回合1次，支付800基本分才能发动。从卡组把「机壳工具 丑恶」以外的1张「机壳」卡加入手卡。
-- 【怪兽描述】
-- 正在准备以副本模式启动系统...
-- C:\sophia\sefiroth.exe 执行中发生错误。
-- 正在试图执行来自未知发布者的以下程序。
-- C:\tierra\qliphoth.exe 您想允许执行吗? <Y/N>...[Y]
-- 以自律模式启动系统。
--[[ __CARD_HEADER_END__ ]]

--クリフォート・ツール
function c65518099.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c65518099.splimit)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65518099,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c65518099.cost)
	e3:SetTarget(c65518099.target)
	e3:SetOperation(c65518099.operation)
	c:RegisterEffect(e3)
end
function c65518099.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0xaa)
end
function c65518099.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c65518099.filter(c)
	return c:IsSetCard(0xaa) and not c:IsCode(65518099) and c:IsAbleToHand()
end
function c65518099.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65518099.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65518099.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65518099.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
