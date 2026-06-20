--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 威风妖怪·狐  (ID: 94784213)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L2 / R2
-- ATK 1500 | DEF 1000
-- Setcode: 208
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- 【怪兽效果】
-- 「威风妖怪·狐」的①的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功时才能发动。从卡组把1张「威风妖怪」陷阱卡加入手卡。
-- ②：这张卡只要在怪兽区域存在，不会成为对方的效果的对象，不会被对方的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--マジェスペクター・フォックス
function c94784213.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCountLimit(1,94784213)
	e2:SetTarget(c94784213.thtg)
	e2:SetOperation(c94784213.thop)
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
function c94784213.thfilter(c)
	return c:IsSetCard(0xd0) and c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c94784213.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94784213.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c94784213.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c94784213.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
