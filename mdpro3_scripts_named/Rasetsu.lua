--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 罗刹  (ID: 43378076)
-- Type: Monster / Effect / Spirit
-- Attribute: FIRE
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 1900
--
-- Effect Text:
-- 这张卡不能特殊召唤。召唤·反转的回合的结束阶段时回到持有者手卡。这张卡召唤·反转时，把「罗刹」以外的手卡1只灵魂怪兽给对方观看才能发动。选择对方场上表侧攻击表示存在的1只怪兽回到持有者手卡。这个效果发
-- 动的回合，自己不能把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--羅刹
function c43378076.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--return
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(43378076,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetCost(c43378076.sretcost)
	e4:SetTarget(c43378076.srettg)
	e4:SetOperation(c43378076.sretop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
end
function c43378076.cfilter(c)
	return c:IsType(TYPE_SPIRIT) and not c:IsCode(43378076) and not c:IsPublic()
end
function c43378076.sretcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0
		and Duel.IsExistingMatchingCard(c43378076.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c43378076.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c43378076.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAbleToHand()
end
function c43378076.srettg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c43378076.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43378076.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c43378076.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c43378076.sretop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
