--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 月光轮回舞踊  (ID: 11193246)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 223
--
-- Effect Text:
-- 「月光轮回舞踊」在1回合只能发动1张。
-- ①：自己场上的怪兽被战斗·效果破坏的场合才能发动。从卡组把最多2只「月光」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--月光輪廻舞踊
function c11193246.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,11193246+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c11193246.condition)
	e1:SetTarget(c11193246.target)
	e1:SetOperation(c11193246.operation)
	c:RegisterEffect(e1)
end
function c11193246.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c11193246.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11193246.cfilter,1,nil,tp)
end
function c11193246.thfilter(c)
	return c:IsSetCard(0xdf) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c11193246.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11193246.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11193246.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11193246.thfilter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
