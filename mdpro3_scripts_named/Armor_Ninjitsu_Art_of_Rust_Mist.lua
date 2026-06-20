--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 机甲忍法 锈蚀水雾  (ID: 2148918)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 97
--
-- Effect Text:
-- 自己场上有名字带有「忍者」的怪兽存在，对方场上有怪兽特殊召唤时，那些特殊召唤的怪兽的攻击力变成一半。
--[[ __CARD_HEADER_END__ ]]

--機甲忍法ラスト・ミスト
function c2148918.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2148918,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c2148918.spcon)
	e2:SetTarget(c2148918.sptg)
	e2:SetOperation(c2148918.spop)
	c:RegisterEffect(e2)
end
function c2148918.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c2148918.tgfilter(c,e,tp)
	return c:IsFaceup() and c:IsControler(tp) and (not e or c:IsRelateToEffect(e))
end
function c2148918.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2148918.tgfilter,1,nil,nil,1-tp) and Duel.IsExistingMatchingCard(c2148918.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c2148918.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
end
function c2148918.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c2148918.tgfilter,nil,e,1-tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
