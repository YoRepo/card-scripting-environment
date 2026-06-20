--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 超重剑圣 武藏-C  (ID: 75988594)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- ATK 300 | DEF 2300
-- Setcode: 154
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡在规则上也当作「超重武者」卡使用。
-- ①：这张卡同调召唤成功时，以自己墓地1只机械族怪兽为对象才能发动。那只怪兽加入手卡。自己墓地有魔法·陷阱卡存在的场合，这个回合自己不能把那只怪兽以及那些同名怪兽召唤·特殊召唤。
-- ②：这张卡可以用表侧守备表示的状态作出攻击。那个场合，这张卡用守备力当作攻击力使用进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--超重剣聖ムサ－C
function c75988594.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75988594,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c75988594.thcon)
	e2:SetTarget(c75988594.thtg)
	e2:SetOperation(c75988594.thop)
	c:RegisterEffect(e2)
	--defense attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c75988594.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c75988594.thfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAbleToHand()
end
function c75988594.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c75988594.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75988594.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c75988594.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c75988594.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		if Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CANNOT_SUMMON)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(1,0)
			e1:SetTarget(c75988594.sumlimit)
			e1:SetLabel(tc:GetCode())
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c75988594.sumlimit(e,c)
	return c:IsCode(e:GetLabel())
end
