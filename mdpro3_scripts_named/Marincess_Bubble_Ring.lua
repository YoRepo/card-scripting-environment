--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 海晶少女涡轮  (ID: 19712214)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 299
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己或者对方的怪兽的攻击宣言时才能发动。那次攻击无效，从自己的额外卡组·墓地选1只「海晶少女 水晶心」特殊召唤。
-- ②：把墓地的这张卡除外，以自己场上1只连接2以上的「海晶少女」连接怪兽为对象才能发动。这个回合，那只怪兽在同1次的战斗阶段中可以作出最多有自身的连接标记数量的攻击，那只怪兽的战斗发生的对对方的战斗伤害
-- 变成0。
--[[ __CARD_HEADER_END__ ]]

--海晶乙女渦輪
function c19712214.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,19712214+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c19712214.target)
	e1:SetOperation(c19712214.activate)
	c:RegisterEffect(e1)
	--extra attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(aux.bpcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c19712214.attg)
	e2:SetOperation(c19712214.atop)
	c:RegisterEffect(e2)
end
function c19712214.spfilter(c,e,tp)
	return c:IsCode(67712104) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_GRAVE) and Duel.GetMZoneCount(tp)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function c19712214.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19712214.spfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
end
function c19712214.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c19712214.spfilter),tp,LOCATION_GRAVE+LOCATION_EXTRA,0,nil,e,tp)
	if Duel.NegateAttack() and #g>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c19712214.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b) and c:IsType(TYPE_LINK) and c:IsLinkAbove(2)
end
function c19712214.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c19712214.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c19712214.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c19712214.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c19712214.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(tc:GetLink()-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e2:SetCondition(c19712214.damcon)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e2:SetOwnerPlayer(tp)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e3:SetCondition(c19712214.damcon2)
		e3:SetValue(1)
		tc:RegisterEffect(e3)
	end
end
function c19712214.damcon(e)
	return e:GetHandlerPlayer()==e:GetOwnerPlayer()
end
function c19712214.damcon2(e)
	return 1-e:GetHandlerPlayer()==e:GetOwnerPlayer()
end
