--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: DDD 磐石王 大流士  (ID: 51497409)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Fiend
-- Rank 3
-- ATK 1900 | DEF 1000
-- Setcode: 4271
--
-- Effect Text:
-- 恶魔族3星怪兽×2
-- ①：1回合1次，把这张卡1个超量素材取除，以自己场上1张「契约书」卡为对象才能发动。那张卡破坏，自己从卡组抽1张。这个效果在对方回合也能发动。
-- ②：这张卡和对方怪兽进行战斗的伤害计算时，把这张卡1个超量素材取除才能发动。这张卡不会被那次战斗破坏，伤害计算后那只对方怪兽破坏，给与对方500伤害。
--[[ __CARD_HEADER_END__ ]]

--DDD磐石王ダリウス
function c51497409.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FIEND),3,2)
	--Destroy and Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51497409,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c51497409.cost)
	e1:SetTarget(c51497409.ddtg)
	e1:SetOperation(c51497409.ddop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51497409,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c51497409.incon)
	e2:SetCost(c51497409.cost)
	e2:SetOperation(c51497409.inop)
	c:RegisterEffect(e2)
end
function c51497409.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c51497409.ddfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xae)
end
function c51497409.ddtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c51497409.ddfilter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingTarget(c51497409.ddfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c51497409.ddfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c51497409.ddop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c51497409.incon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsControler(1-tp)
end
function c51497409.inop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLED)
		e2:SetOperation(c51497409.desop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e2)
	end
end
function c51497409.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dc=c:GetBattleTarget()
	if dc and Duel.Destroy(dc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
end
