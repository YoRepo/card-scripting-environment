--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 战华之德-刘玄  (ID: 40428851)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast-Warrior
-- Level 4
-- ATK 1400 | DEF 1200
-- Setcode: 311
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要自己场上有其他的「战华」怪兽存在，对方不能选择这张卡作为攻击对象。
-- ②：对方场上的怪兽数量比自己场上的怪兽多的场合，从自己的手卡·场上把1张卡送去墓地才能发动。从卡组把「战华之德-刘玄」以外的1只「战华」怪兽特殊召唤。
-- ③：这张卡以外的自己的「战华」怪兽进行战斗的攻击宣言时才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--戦華の徳－劉玄
function c40428851.initial_effect(c)
	--can not be attack target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c40428851.atcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40428851,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,40428851)
	e2:SetCondition(c40428851.spcon)
	e2:SetCost(c40428851.spcost)
	e2:SetTarget(c40428851.sptg)
	e2:SetOperation(c40428851.spop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(40428851,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,40428852)
	e3:SetCondition(c40428851.drcon)
	e3:SetTarget(c40428851.drtg)
	e3:SetOperation(c40428851.drop)
	c:RegisterEffect(e3)
end
function c40428851.atfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x137)
end
function c40428851.atcon(e)
	return Duel.IsExistingMatchingCard(c40428851.atfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c40428851.spfilter(c,e,tp)
	return c:IsSetCard(0x137) and c:IsType(TYPE_MONSTER) and not c:IsCode(40428851) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c40428851.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
end
function c40428851.costfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0 and c:IsAbleToGraveAsCost()
end
function c40428851.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40428851.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c40428851.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c40428851.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40428851.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c40428851.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c40428851.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c40428851.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=Duel.GetAttacker()
	local tc=Duel.GetAttackTarget()
	if not ac:IsControler(tp) then ac,tc=tc,ac end
	return ac and ac:IsControler(tp) and ac:IsFaceup() and ac:IsSetCard(0x137) and ac~=c
end
function c40428851.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c40428851.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
