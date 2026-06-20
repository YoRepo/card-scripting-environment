--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 装弹枪管狞猛龙  (ID: 27548199)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2500
-- Setcode: 271
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡同调召唤成功的场合才能发动。从自己墓地选1只连接怪兽当作装备卡使用给这张卡装备，那个连接标记数量的枪管指示物给这张卡放置。
-- ②：这张卡的攻击力上升这张卡的效果装备的怪兽的攻击力一半数值。
-- ③：对方的效果发动时，把这张卡1个枪管指示物取除才能发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--ヴァレルロード・S・ドラゴン
function c27548199.initial_effect(c)
	c:EnableCounterPermit(0x4b)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetDescription(aux.Stringid(27548199,0))
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c27548199.eqcon)
	e1:SetTarget(c27548199.eqtg)
	e1:SetOperation(c27548199.eqop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27548199,1))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,27548199)
	e2:SetCondition(c27548199.discon)
	e2:SetCost(c27548199.discost)
	e2:SetTarget(c27548199.distg)
	e2:SetOperation(c27548199.disop)
	c:RegisterEffect(e2)
end
function c27548199.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c27548199.eqfilter(c,tp,mc)
	return c:IsType(TYPE_LINK) and c:CheckUniqueOnField(tp) and not c:IsForbidden() and mc:IsCanAddCounter(0x4b,c:GetLink())
end
function c27548199.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c27548199.eqfilter,tp,LOCATION_GRAVE,0,1,nil,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,0)
end
function c27548199.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c27548199.eqfilter),tp,LOCATION_GRAVE,0,1,1,nil,tp,c)
	local tc=g:GetFirst()
	if tc then
		if not Duel.Equip(tp,tc,c) then return end
		local lk=tc:GetLink()
		if lk>0 then
			c:AddCounter(0x4b,lk)
		end
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c27548199.eqlimit)
		tc:RegisterEffect(e1)
		local atk=tc:GetAttack()
		if atk>0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetValue(math.ceil(atk/2))
			tc:RegisterEffect(e2)
		end
	end
end
function c27548199.eqlimit(e,c)
	return e:GetOwner()==c
end
function c27548199.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c27548199.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x4b,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x4b,1,REASON_COST)
end
function c27548199.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c27548199.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
