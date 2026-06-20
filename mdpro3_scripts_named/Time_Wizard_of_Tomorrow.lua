--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 时间魔导士  (ID: 26273196)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 5
-- ATK 2000 | DEF 1900
--
-- Effect Text:
-- 「时间魔术师」＋效果怪兽
-- ①：1回合1次，这张卡是已融合召唤的场合才能发动。进行1次投掷硬币，对里表作猜测。猜中的场合，场上的怪兽全部破坏，对方受到表侧表示破坏的怪兽的原本攻击力合计数值一半的伤害。猜错的场合，场上的怪兽全部破
-- 坏，自己受到表侧表示破坏的怪兽的原本攻击力合计数值一半的伤害。
--[[ __CARD_HEADER_END__ ]]

--時の魔導士
function c26273196.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,71625222,aux.FilterBoolFunction(Card.IsFusionType,TYPE_EFFECT),1,true,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26273196,0))
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c26273196.descon)
	e1:SetTarget(c26273196.destg)
	e1:SetOperation(c26273196.desop)
	c:RegisterEffect(e1)
	--fusion check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCondition(c26273196.matcon)
	e2:SetOperation(c26273196.matop)
	c:RegisterEffect(e2)
end
function c26273196.matcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c26273196.matop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(26273196,RESET_EVENT+0xd6c0000,0,1)
end
function c26273196.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(26273196)>0
end
function c26273196.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c26273196.damfilter(c)
	if c:IsPreviousPosition(POS_FACEUP) then
		return math.max(c:GetTextAttack(),0)
	else
		return 0
	end
end
function c26273196.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
		local coin=Duel.AnnounceCoin(tp)
		local res=Duel.TossCoin(tp,1)
		local damp=0
		if coin~=res then
			damp=1-tp
		else
			damp=tp
		end
		if Duel.Destroy(g,REASON_EFFECT)~=0 then
			local og=Duel.GetOperatedGroup()
			local atk=math.ceil((og:GetSum(c26273196.damfilter))/2)
			Duel.Damage(damp,atk,REASON_EFFECT)
		end
	end
end
