--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 娱乐伙伴 骷髅杂技小丑  (ID: 40318957)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L8 / R8
-- ATK 1800 | DEF 100
-- Setcode: 159
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：自己不是「娱乐伙伴」怪兽、「魔术师」灵摆怪兽、「异色眼」怪兽不能灵摆召唤。这个效果不会被无效化。
-- 【怪兽效果】
-- ①：这张卡召唤时才能发动。「娱乐伙伴 骷髅杂技小丑」以外的「娱乐伙伴」怪兽、「魔术师」灵摆怪兽、「异色眼」怪兽之内任意1只从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--EMドクロバット・ジョーカー
function c40318957.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c40318957.splimit)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(40318957,0))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c40318957.thtg)
	e3:SetOperation(c40318957.thop)
	c:RegisterEffect(e3)
end
function c40318957.filter(c)
	return c:IsSetCard(0x9f) or (c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM)) or c:IsSetCard(0x99)
end
function c40318957.splimit(e,c,tp,sumtp,sumpos)
	return not c40318957.filter(c) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c40318957.thfilter(c)
	return c40318957.filter(c) and not c:IsCode(40318957) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c40318957.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40318957.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c40318957.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c40318957.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
