--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 龙骑兵团征兵  (ID: 52962804)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 41
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这张卡的发动时，可以以自己墓地1只4星以下的「龙骑兵团」怪兽为对象。那个场合，那只怪兽加入手卡。
-- ②：这张卡在魔法与陷阱区域存在，原本等级是5星以上的自己的「龙骑兵团」怪兽攻击的场合，那只怪兽直到伤害步骤结束时不受对方的效果影响。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ・ドラフト
function c52962804.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,52962804+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c52962804.target)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c52962804.immtg)
	e2:SetValue(c52962804.efilter)
	c:RegisterEffect(e2)
end
function c52962804.thfilter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x29) and c:IsAbleToHand()
end
function c52962804.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c52962804.thfilter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c52962804.thfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(52962804,0)) then
		e:SetCategory(CATEGORY_TOHAND)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c52962804.activate)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectTarget(tp,c52962804.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c52962804.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c52962804.immtg(e,c)
	return c:GetOriginalLevel()>=5 and c:IsSetCard(0x29) and Duel.GetAttacker()==c
end
function c52962804.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
