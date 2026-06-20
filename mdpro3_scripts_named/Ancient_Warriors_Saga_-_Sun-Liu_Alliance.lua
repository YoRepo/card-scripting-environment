--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 战华史略-孙刘同盟  (ID: 58116537)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 311
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上的「战华」怪兽的属性是2种类以上的场合，宣言1个属性才能发动。持有宣言的属性的对方场上的全部怪兽直到回合结束时不能把效果发动。
-- ②：对方对怪兽的特殊召唤成功的场合或者自己把「战华」怪兽的效果发动的场合才能发动。自己场上的全部「战华」怪兽的攻击力直到回合结束时上升自己场上的「战华」怪兽数量×300。
--[[ __CARD_HEADER_END__ ]]

--戦華史略－孫劉同盟
function c58116537.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--can not activate effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58116537,0))
	e1:SetCategory(CATEGORY_ANNOUNCE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,58116537)
	e1:SetCondition(c58116537.actcon)
	e1:SetTarget(c58116537.acttg)
	e1:SetOperation(c58116537.actop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(58116537,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,58116538)
	e2:SetCondition(c58116537.atkcon)
	e2:SetTarget(c58116537.atktg)
	e2:SetOperation(c58116537.atkop)
	c:RegisterEffect(e2)
	local e4=e2:Clone()
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c58116537.atkcon2)
	c:RegisterEffect(e4)
end
function c58116537.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x137)
end
function c58116537.actcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local sg=g:Filter(c58116537.cfilter,nil)
	return sg and sg:GetClassCount(Card.GetAttribute)>=2
end
function c58116537.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return aux.GetAttributeCount(g)>0 end
	local tc=g:GetFirst()
	local att=0
	while tc do
		att=bit.bor(att,tc:GetAttribute())
		tc=g:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local ac=Duel.AnnounceAttribute(tp,1,att)
	e:SetLabel(ac)
end
function c58116537.actop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local sg=g:Filter(Card.IsAttribute,nil,e:GetLabel())
	if sg:GetCount()<=0 then return end
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
		tc=sg:GetNext()
	end
end
function c58116537.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x137)
end
function c58116537.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function c58116537.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58116537.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c58116537.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58116537.atkfilter,tp,LOCATION_MZONE,0,nil)
	local gc=g:GetCount()
	if gc>0 then
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(gc*300)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
function c58116537.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x137) and rp==tp
end
