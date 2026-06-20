--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 双工器奇美拉  (ID: 78084378)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 5
-- ATK 2000 | DEF 800
--
-- Effect Text:
-- 电子界族怪兽×2
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，把自己场上1只电子界族怪兽解放才能发动。这个回合的战斗阶段中双方不能把魔法·陷阱卡的效果发动。
-- ②：融合召唤的这张卡被送去墓地的场合，以这张卡以外的自己墓地1只电子界族怪兽和1张「电脑网融合」为对象才能发动。那些卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ダイプレクサ・キマイラ
function c78084378.initial_effect(c)
	--fusion material
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsRace,RACE_CYBERSE),2,true)
	c:EnableReviveLimit()
	--lock
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78084378,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c78084378.con)
	e1:SetCost(c78084378.cost)
	e1:SetOperation(c78084378.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78084378,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,78084378)
	e2:SetCondition(c78084378.thcon)
	e2:SetTarget(c78084378.thtg)
	e2:SetOperation(c78084378.thop)
	c:RegisterEffect(e2)
end
function c78084378.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c78084378.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_CYBERSE) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_CYBERSE)
	Duel.Release(g,REASON_COST)
end
function c78084378.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetCondition(c78084378.accon)
	e1:SetValue(c78084378.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c78084378.accon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c78084378.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c78084378.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_FUSION)
end
function c78084378.filter1(c)
	return c:IsRace(RACE_CYBERSE) and c:IsAbleToHand()
end
function c78084378.filter2(c)
	return c:IsCode(65801012) and c:IsAbleToHand()
end
function c78084378.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c78084378.filter1,tp,LOCATION_GRAVE,0,1,e:GetHandler())
		and Duel.IsExistingTarget(c78084378.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectTarget(tp,c78084378.filter1,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectTarget(tp,c78084378.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
end
function c78084378.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
