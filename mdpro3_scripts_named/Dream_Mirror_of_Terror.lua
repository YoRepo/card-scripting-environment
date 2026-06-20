--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 黯黑之梦魔镜  (ID: 1050355)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要自己场上有暗属性「梦魔镜」怪兽存在，每次对方对怪兽的特殊召唤成功，给与对方300伤害。
-- ②：自己·对方的结束阶段，把自己的场地区域的这张卡除外才能发动。从手卡·卡组把1张「圣光之梦魔镜」发动。
--[[ __CARD_HEADER_END__ ]]

--闇黒の夢魔鏡
function c1050355.initial_effect(c)
	aux.AddCodeList(c,74665651)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1050355,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,1050355)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c1050355.acttg)
	e2:SetOperation(c1050355.actop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c1050355.damcon)
	e3:SetOperation(c1050355.damop)
	c:RegisterEffect(e3)
end
function c1050355.actfilter(c,tp)
	return c:IsCode(74665651) and c:GetActivateEffect() and c:GetActivateEffect():IsActivatable(tp,true,true)
end
function c1050355.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1050355.actfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,tp) end
end
function c1050355.actop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c1050355.actfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		te:UseCountLimit(tp,1,true)
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
	end
end
function c1050355.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x131) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c1050355.cfilter2(c,tp)
	return c:IsSummonPlayer(tp)
end
function c1050355.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c1050355.cfilter1,tp,LOCATION_MZONE,0,1,nil)
		and eg:IsExists(c1050355.cfilter2,1,nil,1-tp)
end
function c1050355.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,1050355)
	Duel.Damage(1-tp,300,REASON_EFFECT)
end
